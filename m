Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268373AbTBSQg3>; Wed, 19 Feb 2003 11:36:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268467AbTBSQg3>; Wed, 19 Feb 2003 11:36:29 -0500
Received: from 212-170-21-172.uc.nombres.ttd.es ([212.170.21.172]:39344 "EHLO
	omega.resa.es") by vger.kernel.org with ESMTP id <S268373AbTBSQg2>;
	Wed, 19 Feb 2003 11:36:28 -0500
Date: Wed, 19 Feb 2003 17:46:19 +0100
To: linux-kernel@vger.kernel.org
Subject: Re: [PROBLEM] PDC20269 on smp and up
Message-ID: <20030219164619.GA22643@omega.resa.es>
Mail-Followup-To: piotr, linux-kernel@vger.kernel.org
References: <20030219135545.GA5328@omega.resa.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030219135545.GA5328@omega.resa.es>
User-Agent: Mutt/1.3.28i
From: Pedro Larroy <piotr@omega.resa.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The old PDC driver works well on UP with two 20269 cards. 
The old PDC driver hangs even with one card on SMP box.
The new PDC driver hangs on UP with two cards, when accessing a lot of the
disks at once.
The new PDC driver hangs on SMP with two cards.

Those are all my observations.

Ragards.

-- 
O   _____________________________________________________________   O
|  /-| Pedro Larroy Tovar. PiotR | http://omega.resa.es/piotr  |-\  |
| /--|            No MS-Office attachments please.             |--\ |
o-|--|              e-mail: piotr@omega.resa.es                |--|-o 
   \-|   finger piotr@omega.resa.es for public key and info    |-/  
    -------------------------------------------------------------
