Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313194AbSDTWq6>; Sat, 20 Apr 2002 18:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313201AbSDTWq5>; Sat, 20 Apr 2002 18:46:57 -0400
Received: from smtp-send.myrealbox.com ([192.108.102.143]:38820 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id <S313194AbSDTWq5>; Sat, 20 Apr 2002 18:46:57 -0400
Subject: Re: power off (again)
From: "Trever L. Adams" <tadams-lists@myrealbox.com>
To: Rob Landley <landley@trommello.org>
Cc: Thunder from the hill <thunder@ngforever.de>,
        Christian Schoenebeck <christian.schoenebeck@epost.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020420200430.337D1730@merlin.webofficenow.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.4 
Date: 20 Apr 2002 15:46:53 -0700
Message-Id: <1019342816.1165.0.camel@aurora>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-04-20 at 06:45, Rob Landley wrote:
> Unless your patch is reversed, that's what I've got (on the red hat systems, 
> the linux from scratch systems use BSD style init scripts because I'm not 
> THAT masochistic).  It doesn't help.

It is reversed.  If you want power off, you do need the -p.

Trever

