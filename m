Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315020AbSD2Kcu>; Mon, 29 Apr 2002 06:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315024AbSD2Kct>; Mon, 29 Apr 2002 06:32:49 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:12051 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S315020AbSD2Kcs>; Mon, 29 Apr 2002 06:32:48 -0400
Subject: Re: getting a programs ENV via ptrace ?
To: sonnenburg@informatik.hu-berlin.de (Soeren Sonnenburg)
Date: Mon, 29 Apr 2002 11:18:09 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1020068756.5050.7.camel@sun> from "Soeren Sonnenburg" at Apr 29, 2002 10:25:55 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1728ET-0005mb-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I am looking for a way of getting the environment variables of a running
> process.
> Is this possible by using the ptrace interface somehow ?

Take a look at the code to ps
