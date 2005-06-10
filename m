Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262313AbVFJJfp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262313AbVFJJfp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 05:35:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262536AbVFJJfp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 05:35:45 -0400
Received: from wproxy.gmail.com ([64.233.184.201]:51935 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262313AbVFJJfb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 05:35:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=G86Mntliv50wfvXUoNTiIu7dKugHvJzek0tCiGqQ+5gkBV2hS227gn/j9JYN5U5+8z4WXkzQZNcJNgP8BqvduMOHJ2/Lg0F2/OW4Rk1NebSDvDNj/QGJOrvu/bouUGNWjQHwmhNjNQqwNAw10sNB5kncPshuaTqyqdXAsPqAP6w=
Message-ID: <98df96d305061002356359441b@mail.gmail.com>
Date: Fri, 10 Jun 2005 18:35:31 +0900
From: Hiro Yoshioka <lkml.hyoshiok@gmail.com>
Reply-To: hyoshiok@miraclelinux.com
To: Hideki.Takahashi@uniadex.co.jp
Subject: Re: Dump analysis tool Alicia is released
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <034D06CB98C3DA48A82AC64141B6604E0596ACEF@AA02S1MB01.nthq01.unisys.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <034D06CB98C3DA48A82AC64141B6604E0596ACEF@AA02S1MB01.nthq01.unisys.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The development of alicia is partly supported by IPA and the following is an
information of the activities.

http://www.ipa.go.jp/software/open/forum/NEAforum.html

http://www.ipa.go.jp/software/open/forum/Contents/DevInfraWG/Alicia_Ev01.pdf

The WG1 did run Web/DB/OS benchmarks and develop Alicia/LKST/DAV tools.

Enjoy,
  Hiro

On 6/7/05, Hideki.Takahashi@uniadex.co.jp
<Hideki.Takahashi@uniadex.co.jp> wrote:
> Dear all,
> 
> We are pleased to announce releasing a new dump analysis tool,
> Alicia (Advanced LInux Crash-dump Interactive Analyzer).
> 
> ---
> The development of this program is partly supported by IPA
> (Information-Technology Promotion Agency, Japan).
> 
> ---
> 
> Alicia is a program that provides effective dump analysis environment
> with power of Perl language. Alicia provides common access method to
> kernel by wrapping the existing tool crash/lcrash and provides 
> "scripting" function for saving and reusing the dump analysis procedures.
> User can use existing crash/lcrash commands in addition to Alicia
> commands. The command result can be saved as a variable and it can
> be used as a parameter of another command. 
> Please use this tool and give us some comments.
> 
> The following software is necessary for the compilation and the
> execution of Alicia.
>  - crash 3.8.5 or higher
>  - Perl 5.8.0 or higher
>  - Perl module Term::ReadKey 2.21 or higher
>  - Perl module Term::ReadLine::Perl 1.0203 or higer
> 
> ---
> Alicia source code and documents are available in the following site,
> http://sourceforge.net/projects/alicia/
> http://alicia.sourceforge.net/
> 
> We prepared a mailing list written below in order to let users know
> update of Alicia.
> alicia-users@lists.sourceforge.net
> 
> And if you have any comments, please send to the above list, or to
> another mailing-list written below.
> alicia-devel@lists.sourceforge.net
> 
> Best regards,
> All of the Alicia developers
> 
> -----------------
> Hideki Takahashi
> Uniadex,Ltd., Software Product Support
> E-mail: Hideki.Takahashi@uniadex.co.jp
> 
> -
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
