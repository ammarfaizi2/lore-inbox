Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262348AbVDFXWd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262348AbVDFXWd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 19:22:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262353AbVDFXWd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 19:22:33 -0400
Received: from wproxy.gmail.com ([64.233.184.194]:57674 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262348AbVDFXWa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 19:22:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=XJS9fO4kyagOSs43kFxnCuH0T/mRoOyZJhuOFyuQVlTdjqE6fmWJFbLI49YCBWlEICuh2lHFuC39Od0DesMoQAaUfDZjacBp25eootNPKE/tYv42hNm27yx8pYU6RkXYJIKdHPSwO5ncxdC124RM0YIAfekPUx/cskOJF2I498k=
Message-ID: <35fb2e590504061622364f72a@mail.gmail.com>
Date: Thu, 7 Apr 2005 00:22:30 +0100
From: Jon Masters <jonmasters@gmail.com>
Reply-To: jonathan@jonmasters.org
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Kernel SCM saga..
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 6, 2005 4:42 PM, Linus Torvalds <torvalds@osdl.org> wrote:

> as a number of people are already aware (and in some
> cases have been aware over the last several weeks), we've
> been trying to work out a conflict over BK usage over the last
> month or two (and it feels like longer ;). That hasn't been
> working out, and as a result, the kernel team is looking at
> alternatives.

What about the 64K changeset limitation in current releases?

Did I miss something (like the fixes promised) or is there going to be
another interim release before the end of support?

Jon.

P.S. Apologies if this already got addressed.
