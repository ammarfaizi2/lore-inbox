Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314149AbSIHT7g>; Sun, 8 Sep 2002 15:59:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314278AbSIHT7g>; Sun, 8 Sep 2002 15:59:36 -0400
Received: from 62-190-216-245.pdu.pipex.net ([62.190.216.245]:54023 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S314149AbSIHT7g>; Sun, 8 Sep 2002 15:59:36 -0400
From: jbradford@dial.pipex.com
Message-Id: <200209082011.g88KBsdj004134@darkstar.example.net>
Subject: Re: ide drive dying?
To: ed.sweetman@WMICH.EDU (Ed Sweetman)
Date: Sun, 8 Sep 2002 21:11:53 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3D7BA4BC.5050904@wmich.edu> from "Ed Sweetman" at Sep 08, 2002 03:27:56 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Keep your drive cool and you can expect to keep it around for a very 
> long time.

In a large tower case, it is worth while to leave a drive bay free between disks, instead of using them sequentially, like this:

    ------             ------
    |****|             |****|
    ------             ------
    |    |             |****|
    ------             ------
    |****|             |****|
    ------  instead of ------
    |    |             |    |
    ------             ------
    |****|             |    |
    ------             ------
    |    |             |    |
    ------             ------

Also, if you get a disk that suddenly doesn't spin up, don't assume that the motor has died - you can sometimes bring them back to life by connecting power to them, and giving them a very sharp angular jolt in the plane of the platters - the effect is called static friction, (A.K.A. stiction)

John.
