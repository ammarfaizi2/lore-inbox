Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264319AbUAMM5O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 07:57:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264315AbUAMM5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 07:57:14 -0500
Received: from matrix.roma2.infn.it ([141.108.255.2]:13710 "EHLO
	matrix.roma2.infn.it") by vger.kernel.org with ESMTP
	id S264319AbUAMM4a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 07:56:30 -0500
From: "Emiliano 'AlberT' Gabrielli" <AlberT@SuperAlberT.it>
Reply-To: AlberT@SuperAlberT.it
Organization: SuperAlberT.it
To: gentile <pierre.gentile@mpsa.com>, linux-kernel@vger.kernel.org
Subject: Re: driver provenance in kernel
Date: Tue, 13 Jan 2004 13:57:13 +0100
User-Agent: KMail/1.5.4
References: <loom.20040113T133054-768@post.gmane.org>
In-Reply-To: <loom.20040113T133054-768@post.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200401131357.13179.AlberT@SuperAlberT.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13:37, martedì 13 gennaio 2004, gentile wrote:
> Hello,
>
> I'd like to hnow if a driver is already present in a kernel before
> atempting to load it as module. I looked into System.map for a key label
> without success :-(
>
> I know it must be a stupid question but if someone could help me anyway ?
>
> Thanks
>

man lsmod

:-)


-- 
<?php echo '       Emiliano `AlberT` Gabrielli       '."\n".
           '  E-Mail: AlberT_AT_SuperAlberT_it  '."\n".
           '  Web:    http://SuperAlberT.it  '."\n".
'  IRC:    #php,#AES azzurra.com '."\n".'ICQ: 158591185'; ?>

