Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130600AbRBPSrU>; Fri, 16 Feb 2001 13:47:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130821AbRBPSrL>; Fri, 16 Feb 2001 13:47:11 -0500
Received: from oberon.gaumina.lt ([193.219.244.227]:24582 "HELO
	oberon.gaumina.lt") by vger.kernel.org with SMTP id <S130600AbRBPSq7> convert rfc822-to-8bit;
	Fri, 16 Feb 2001 13:46:59 -0500
From: Andrius Adomaitis <charta@gaumina.lt>
To: Stéphane Borel <stef@via.ecp.fr>,
        linux-kernel@vger.kernel.org
Subject: Re: ServeRaid 4M with IBM netfinity and kernel 2.4.x
Date: Fri, 16 Feb 2001 20:45:49 +0100
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="us-ascii"
In-Reply-To: <20010216032956.B11267@via.ecp.fr>
In-Reply-To: <20010216032956.B11267@via.ecp.fr>
MIME-Version: 1.0
Message-Id: <0102162045490L.00312@castle.gaumina.lt>
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 16 February 2001 03:29, Stéphane Borel wrote:

> I should add that the behaviour of serveraid under 2.4 is somehow
> strange : during fsck for instance, it seems to get stuck and won't
> go further if we don't strike a key on the keyboard.

It just a gues, but try disable write back cache. I had similar 
problems with intel crcu31 RAID controller. 

Good luck.
--
Andrius
charta@gaumina.lt
