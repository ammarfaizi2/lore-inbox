Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262283AbSIZKnb>; Thu, 26 Sep 2002 06:43:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262284AbSIZKnb>; Thu, 26 Sep 2002 06:43:31 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:34666 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S262283AbSIZKna>; Thu, 26 Sep 2002 06:43:30 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200209261048.g8QAmfO15438@devserv.devel.redhat.com>
Subject: Re: hpt370 raid driver
To: Wilfried.Weissmann@gmx.at (Wilfried Weissmann)
Date: Thu, 26 Sep 2002 06:48:41 -0400 (EDT)
Cc: arjanv@redhat.com (Arjan van de Ven), slansky@usa.net (Petr Slansky),
       alan@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <3D9072B8.5090106@gmx.at> from "Wilfried Weissmann" at Sep 24, 2002 04:12:08 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The header files are good. They show the structure of the raid signature 
> and some info about the event logs. They could be reused by the linux 
> module, however I do not know if the copyright is a problem there. Does 
> anyone know...?

I dont think it shows anything our hptraid module doesnt alreayd know
