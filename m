Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318210AbSGQKdP>; Wed, 17 Jul 2002 06:33:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318241AbSGQKdO>; Wed, 17 Jul 2002 06:33:14 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:53493 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S318210AbSGQKdM>; Wed, 17 Jul 2002 06:33:12 -0400
Date: Wed, 17 Jul 2002 12:36:06 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: David Gironella Casademont <giro@hades.udg.es>
cc: linux-kernel@vger.kernel.org
Subject: Re: Highmen
In-Reply-To: <Pine.LNX.4.30.0207171144460.2244-100000@hades.udg.es>
Message-ID: <Pine.NEB.4.44.0207171234350.16056-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Jul 2002, David Gironella Casademont wrote:

> I have a warnign on my kernel(2.4.19-rc1-ac6) boot say:
> 	Warning only 896MB will be used
> 	Use a HIGHMEM enabled kernel
>
> What i need to activate on .config kernel to use HIGHMEM?
>
> PS i have 1gb ram.

In the menu "Processor type and features" there's a menu entry
"High Memory Support". Change the value from "off" to "4GB".

> Giro

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

