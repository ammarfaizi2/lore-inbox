Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262430AbSJVKsP>; Tue, 22 Oct 2002 06:48:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262442AbSJVKsP>; Tue, 22 Oct 2002 06:48:15 -0400
Received: from 62-190-203-143.pdu.pipex.net ([62.190.203.143]:62218 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S262430AbSJVKsO>; Tue, 22 Oct 2002 06:48:14 -0400
From: jbradford@dial.pipex.com
Message-Id: <200210221103.g9MB3dff000792@darkstar.example.net>
Subject: Re: running 2.4.2 kernel under 4MB Ram
To: amolk@ishoni.com (Amol Kumar Lad)
Date: Tue, 22 Oct 2002 12:03:39 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <1035312869.2209.30.camel@amol.in.ishoni.com> from "Amol Kumar Lad" at Oct 22, 2002 02:54:27 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  I want to run 2.4.2 kernel on my embedded system that has only 4 Mb
> SDRAM . Is it possible ?? Is there any constraint for the minimum SDRAM
> requirement for linux 2.4.2

I've successfully run the following kernels all in 4 MB of RAM:

2.2.13
2.2.20
2.4.18
2.4.19
2.5.40
2.5.41
2.5.43

John.
