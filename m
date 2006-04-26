Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932381AbWDZK2x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932381AbWDZK2x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 06:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932371AbWDZK2x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 06:28:53 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:57998 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932381AbWDZK2w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 06:28:52 -0400
Date: Wed, 26 Apr 2006 11:28:42 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Sam Vilain <sam@vilain.net>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, linux-kernel@vger.kernel.org,
       ebiederm@xmission.com
Subject: Re: [RFC][PATCH 4/5] utsname namespaces: sysctl hack
Message-ID: <20060426102842.GA1334@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Sam Vilain <sam@vilain.net>, "Serge E. Hallyn" <serue@us.ibm.com>,
	linux-kernel@vger.kernel.org, ebiederm@xmission.com
References: <20060407095132.455784000@sergelap> <20060407183600.E40C119B902@sergelap.hallyn.com> <4446547B.4080206@sw.ru> <m1wtdlmvmr.fsf@ebiederm.dsl.xmission.com> <20060419175123.GD1238@sergelap.austin.ibm.com> <m1ejztjua2.fsf@ebiederm.dsl.xmission.com> <4446AF56.9060706@vilain.net> <20060425220022.GD7228@sergelap.austin.ibm.com> <444EF25D.9070702@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <444EF25D.9070702@vilain.net>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2006 at 04:09:01PM +1200, Sam Vilain wrote:
> Eric has said that his understanding was that syscall switches (ie,
> syscalls with subcommands) were bad form.

It's not just Eric, it's common sense and pretty broad consensus.

