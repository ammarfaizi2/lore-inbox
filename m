Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261629AbUCVCSJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 21:18:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261631AbUCVCSJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 21:18:09 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:37338 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S261629AbUCVCSH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 21:18:07 -0500
Message-Id: <200403220216.i2M2GPn5006074@eeyore.valparaiso.cl>
To: rudi@lambda-computing.de
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: File change notification (enhanced dnotify) 
In-Reply-To: Your message of "Mon, 22 Mar 2004 02:36:34 +0100."
             <405E4322.5030606@gamemakers.de> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 14)
Date: Sun, 21 Mar 2004 22:16:25 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

=?ISO-8859-1?Q?R=FCdiger_Klaehn?= <rudi@gamemakers.de> said:
> I am working on a mechanism to let programs watch for file system 
> changes in large directory trees or on the whole system. Since my last 
> post in january I have been trying various approaches.

How do you propose to handle the fact that there are changes to _files_,
which happen to be pointed to by entries in directories? There is no
"change in the directory tree" in Unix...
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
