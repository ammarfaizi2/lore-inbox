Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264571AbUGaV3Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264571AbUGaV3Q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 17:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264519AbUGaV3Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 17:29:16 -0400
Received: from holomorphy.com ([207.189.100.168]:10915 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264479AbUGaV3P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 17:29:15 -0400
Date: Sat, 31 Jul 2004 14:29:09 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Sam Ravnborg <sam@ravnborg.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: kbuild: Various updates for 2.6.8
Message-ID: <20040731212909.GH2334@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Sam Ravnborg <sam@ravnborg.org>, Linus Torvalds <torvalds@osdl.org>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <20040731075838.GA7469@mars.ravnborg.org> <20040731211739.GE2334@holomorphy.com> <20040731212547.GA1364@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040731212547.GA1364@mars.ravnborg.org>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 31, 2004 at 02:17:39PM -0700, William Lee Irwin III wrote:
>> By any chance could you update make rpm so it respects the -j flags?
>> Single-threaded make rpm is horrifically slow.

On Sat, Jul 31, 2004 at 11:25:47PM +0200, Sam Ravnborg wrote:
> I have below patch queue up already but will try to experiment with
> a better fix. Something where we pass all options to make.
> I have to redo some of the package stuff anyway cause today there needs
> to be too much arch dependent knowledge spread out in several files.
> But for now klibc is on top of the list, the package stuff will wait a bit.

This will work fine for me.

Thanks.


-- wli
