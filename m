Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266702AbSLDPp4>; Wed, 4 Dec 2002 10:45:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266712AbSLDPp4>; Wed, 4 Dec 2002 10:45:56 -0500
Received: from [64.76.155.18] ([64.76.155.18]:27544 "EHLO alumno.inacap.cl")
	by vger.kernel.org with ESMTP id <S266702AbSLDPpz>;
	Wed, 4 Dec 2002 10:45:55 -0500
Date: Wed, 4 Dec 2002 12:53:13 -0300 (CLST)
From: Robinson Maureira Castillo <rmaureira@alumno.inacap.cl>
To: zippel@linux-m68k.org
cc: linux-kernel@vger.kernel.org
Subject: Strange options when doing make allnoconfig
Message-ID: <Pine.LNX.4.44.0212041248370.20359-100000@alumno.inacap.cl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
doing make allnoconfig includes a pair of options that made me blink 
twice

CONFIG_SOUND_GAMEPORT=y
CONFIG_MSDOS_PARTITION=y

Are this included on purpose, or did they just slipped? 8)

Best regards
-- 
Robinson Maureira Castillo
Asesor DAI
INACAP

