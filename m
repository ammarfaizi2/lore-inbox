Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264889AbTFLQ2t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 12:28:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264890AbTFLQ2t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 12:28:49 -0400
Received: from smtphost.cis.strath.ac.uk ([130.159.196.96]:32492 "EHLO
	smtphost.cis.strath.ac.uk") by vger.kernel.org with ESMTP
	id S264889AbTFLQ2s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 12:28:48 -0400
Date: Thu, 12 Jun 2003 17:42:11 +0100
From: iain d broadfoot <ibroadfo@cis.strath.ac.uk>
To: Linux Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.21-rc7 ACPI broken
Message-ID: <20030612164211.GE1501@iain-vaio-fx405>
Mail-Followup-To: Linux Kernel Mailing <linux-kernel@vger.kernel.org>
References: <F760B14C9561B941B89469F59BA3A847E96F22@orsmsx401.jf.intel.com> <Pine.OSF.4.51.0306121825500.300337@tao.natur.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.OSF.4.51.0306121825500.300337@tao.natur.cuni.cz>
X-Editor: Vim http://www.vim.org/
X-Operating-System: Linux/2.4.21-rc8 (i686)
X-Uptime: 17:40:07 up  3:58,  3 users,  load average: 0.09, 0.05, 0.15
X-Message-Flag: Outlook viruses can be made to send private documents from your hard drive to any or all recipients from your address book. But it only happens about once a month or so, so it's okay. Just keep on using it.
User-Agent: Mutt/1.5.4i
X-CIS-MailScanner: Found to be clean
X-CIS-MailScanner-SpamCheck: not spam, SpamAssassin (score=-8.8, required 5,
	BAYES_00 -5.20, IN_REP_TO -0.37, QUOTED_EMAIL_TEXT -0.38,
	REFERENCES -0.00, REPLY_WITH_QUOTES 0.00, USER_AGENT_MUTT -2.80)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Martin MOKREJ? (mmokrejs@natur.cuni.cz) wrote:
> Hi,
>   so I retried the latest patch available from sourceforge site, but that
> is for pre-2.4.21-rc3 candidate. Even worse, some parsed applied with
> offset and in one or two cases got rejected! So I have to wait if patch for
> -rc8 appears or for anything newer. Anyone successfully applied
> acpi-20030523-2.4.21-rc3.diff.gz 7b9551e86393a58d8e6c2b3aeeea2f16
> (md5sum)?

the rc3 acpi patch should apply cleanly to everything upto and including
rc8 (it did for me, anyway. :D).

iain

-- 
wh33, y1p33 3tc.

"If sharing a thing in no way diminishes it, it is not rightly owned if it is
not shared." -St. Augustine
