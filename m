Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265913AbUAUAxU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 19:53:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265921AbUAUAxU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 19:53:20 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:65014 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S265913AbUAUAxT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 19:53:19 -0500
Subject: Re: IDE issues
From: Omkhar Arasaratnam <iamroot@ca.ibm.com>
To: Oliver Hunt <ojh16@student.canterbury.ac.nz>
Cc: Lionel Bouton <Lionel.Bouton@inet6.fr>, linux-kernel@vger.kernel.org
In-Reply-To: <3FE4AAAB.8000209@student.canterbury.ac.nz>
References: <3FE43492.3020703@student.canterbury.ac.nz>
	 <3FE2EFD5.6000009@inet6.fr>  <3FE4AAAB.8000209@student.canterbury.ac.nz>
Content-Type: text/plain
Message-Id: <1074646306.2143.6.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 20 Jan 2004 19:51:47 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-12-21 at 04:01, Oliver Hunt wrote:
> This is 2.6.0, as i said 2.6.0-test11 worked fine on this system running 
> gentoo, and didn't run under debian... grrr...
> 
> Oh well, off to see if this helps...

Can you enclose dmesg / your IDE chipset? I've seen some timing issue
cause by using a generic IDE module instead of a specific bug fix module
(CM640 jumps to mind).....

-- 
Omkhar


