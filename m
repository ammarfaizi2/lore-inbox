Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264960AbUEVMCL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264960AbUEVMCL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 08:02:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264963AbUEVMCL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 08:02:11 -0400
Received: from mail.aei.ca ([206.123.6.14]:53202 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S264960AbUEVMCH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 08:02:07 -0400
From: Ed Tomlinson <edt@aei.ca>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.6-mm] Make i386 boot not so chatty
Date: Sat, 22 May 2004 08:01:53 -0400
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, Zwane Mwaikambo <zwane@arm.linux.org.uk>
References: <Pine.LNX.4.58.0405210032160.2864@montezuma.fsmlabs.com> <20040520234006.291c3dfa.akpm@osdl.org>
In-Reply-To: <20040520234006.291c3dfa.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405220801.53761.edt@aei.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 21, 2004 02:40 am, Andrew Morton wrote:
> Zwane Mwaikambo <zwane@arm.linux.org.uk> wrote:
> >
> > This patch silences the default i386 boot by putting a lot of development
> >  related printks under KERN_DEBUG loglevel, allowing the normal chatty mode
> >  to be turned on by using the 'debug' kernel parameter.
> 
> I think I like it chatty.  Turning this stuff off by default makes kernel
> developers' lives that little bit harder.
> 
> Is the `quiet' option not suitable?

I have been using linux for years with an a few dips into development.  I second
Andrew's idea.  I like the idea of a quiet parm _much_ more than a default quiet mode.

Ed Tomlinson
