Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261154AbVBGPfo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261154AbVBGPfo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 10:35:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261157AbVBGPfo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 10:35:44 -0500
Received: from 90.Red-213-97-199.pooles.rima-tde.net ([213.97.199.90]:63629
	"HELO fargo") by vger.kernel.org with SMTP id S261154AbVBGPfk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 10:35:40 -0500
Date: Mon, 7 Feb 2005 16:35:14 +0100
From: David =?utf-8?B?R8OzbWV6?= <david@pleyades.net>
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Reading Bad DVD Under 2.6.10 freezes the box.
Message-ID: <20050207153514.GA5496@fargo>
Mail-Followup-To: Justin Piszcz <jpiszcz@lucidpixels.com>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.62.0502070728520.1743@p500>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.62.0502070728520.1743@p500>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Justin ;),

On Feb 07 at 07:32:48, Justin Piszcz wrote:
> Main Question >> Why does Linux 'freeze up' when W2K gives a BadCRC error 
> msg (never freezes)?

I don't know, but i can reproduce it too. I complained several months ago
about the problem (in 2.6.7/2.6.8 time) but nobody seemed to care :-/.

I think i still got the bad DVD, to try to reproduce the probelm in
2.6.10.

> The DVD FS is Joilet+ISO (hence, why none of the files are bigger than 
> 2GB), is this normal? 

Mine was Rockridge. It seems the contents are not important. The problem
is reproducible with any broken/scratched DVD.

regards,

-- 
David Gómez                                      Jabber ID: davidge@jabber.org
