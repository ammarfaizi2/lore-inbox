Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289176AbSAGL1w>; Mon, 7 Jan 2002 06:27:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289177AbSAGL1n>; Mon, 7 Jan 2002 06:27:43 -0500
Received: from 213-96-124-18.uc.nombres.ttd.es ([213.96.124.18]:41962 "HELO
	dardhal") by vger.kernel.org with SMTP id <S289176AbSAGL1h>;
	Mon, 7 Jan 2002 06:27:37 -0500
Date: Mon, 7 Jan 2002 12:27:28 +0100
From: =?iso-8859-1?Q?Jos=E9_Luis_Domingo_L=F3pez?= 
	<jdomingo@internautas.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5 suggestion
Message-ID: <20020107112728.GA1768@localhost>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.43.0201071317340.8864-100000@tchiwam2.invers.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.43.0201071317340.8864-100000@tchiwam2.invers.fi>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 07 January 2002, at 14:22:58 +0200,
Philippe Trottier wrote:

> To prevent big confusion after adding or removing hardware (IDE, SCSI,
> Network) would it be possible to assign them an order of detection or
> give them a fixed Major / minor ?
> 
Try devfs. For more information, see:
http://www.atnf.csiro.au/~rgooch/linux/docs/devfs.html

-- 
José Luis Domingo López
Linux Registered User #189436     Debian Linux Woody (P166 64 MB RAM)
 
jdomingo AT internautas DOT   org  => Spam at your own risk

