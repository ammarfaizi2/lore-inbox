Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267467AbTASU5L>; Sun, 19 Jan 2003 15:57:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267625AbTASU5L>; Sun, 19 Jan 2003 15:57:11 -0500
Received: from mbone.iie.cnam.fr ([193.54.195.180]:5138 "EHLO
	mbone.iie.cnam.fr") by vger.kernel.org with ESMTP
	id <S267467AbTASU5L>; Sun, 19 Jan 2003 15:57:11 -0500
From: Arnaud Boulan <boulan@iie.cnam.fr>
To: linux-kernel@vger.kernel.org
Subject: Re: reading from devices in RAW mode
Date: Sun, 19 Jan 2003 22:03:53 +0100
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-ID: <200301192203.53736.boulan@iie.cnam.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I should clarify my question: I do not really mean reading RAW from 
>  the device, but I want to read RAW like how its on this, without any 
>  error-checking or anything. 

Can't ide taskfile access be used for that?
