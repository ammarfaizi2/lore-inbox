Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279028AbRJVWgV>; Mon, 22 Oct 2001 18:36:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279025AbRJVWgI>; Mon, 22 Oct 2001 18:36:08 -0400
Received: from jalon.able.es ([212.97.163.2]:7140 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S279027AbRJVWfK>;
	Mon, 22 Oct 2001 18:35:10 -0400
Date: Tue, 23 Oct 2001 00:35:55 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Michael T . Babcock" <mbabcock@fibrespeed.net>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: VM
Message-ID: <20011023003555.A25439@werewolf.able.es>
In-Reply-To: <3BD420ED.4090508@fibrespeed.net> <E15vffF-00023N-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <E15vffF-00023N-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Oct 22, 2001 at 16:02:49 +0200
X-Mailer: Balsa 1.2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20011022 Alan Cox wrote:
>> I have never done this comparison myself, but I was wondering how ugly 
>> it would be if stable versions of Andrea's and Rik's VMs were both 
>> available in your/Linus' kernel as compile-time options.  Assuming that 
>> each provides better performance under certain conditions, wouldn't 
>
>Too ugly for words.
>-

and how about a CONFIG_ ?? So -ac patch size will become manageable again.

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.2 (Cooker) for i586
Linux werewolf 2.4.12-ac5-beo #1 SMP Mon Oct 22 02:05:06 CEST 2001 i686
