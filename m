Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312750AbSDBPzu>; Tue, 2 Apr 2002 10:55:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312842AbSDBPzk>; Tue, 2 Apr 2002 10:55:40 -0500
Received: from AMontpellier-201-1-4-206.abo.wanadoo.fr ([217.128.205.206]:18819
	"EHLO awak") by vger.kernel.org with ESMTP id <S312750AbSDBPzb> convert rfc822-to-8bit;
	Tue, 2 Apr 2002 10:55:31 -0500
Subject: Re: power off
From: Xavier Bestel <xavier.bestel@free.fr>
To: Christian Schoenebeck <christian.schoenebeck@epost.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020328214032.4F55147B1@debian.heim.lan>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/1.0 (Preview Release)
Date: 02 Apr 2002 17:58:25 +0200
Message-Id: <1017763106.5315.16.camel@bip>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

le jeu 28-03-2002 à 23:04, Christian Schoenebeck a écrit :
> (please cc me)
> 
> Hi everybody!
> 
> I've got a problem with a machine (using an Asus SP98AGP-X mainboard) that 
> doesn't want to power off since moving from 2.2.x to 2.4.x kernel. As I 
> haven't found any other solution, can I simply replace the new apm.c by the 
> old one from 2.2.x or just a part of the unit or would that be fatal?

I have to boot my 2.4 kernels with apm=power-off


