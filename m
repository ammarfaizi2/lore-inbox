Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313865AbSDJVuE>; Wed, 10 Apr 2002 17:50:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313895AbSDJVuD>; Wed, 10 Apr 2002 17:50:03 -0400
Received: from jalon.able.es ([212.97.163.2]:34811 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S313865AbSDJVuC>;
	Wed, 10 Apr 2002 17:50:02 -0400
Date: Wed, 10 Apr 2002 23:49:55 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: 0(1)-patch, where did it go?
Message-ID: <20020410214955.GA1752@werewolf.able.es>
In-Reply-To: <20020409221631.GA1742@werewolf.able.es> <2033233415.1018391675@[10.10.2.3]>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.3.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.04.10 Martin J. Bligh wrote:
>> You can get an up-to-date version in the 2.4.19-pre6-jam1 patcset in
>> 
>> http://giga.cps.unizar.es/~magallon/linux/kernel/
>
>Do you have a version of this broken out as a seperate patch 
>anywhere? There seem to have been updates to the O(1) scheduler 
>in 2.5 since the K3 version of the scheduler, but I've not seen
>any new version of the 2.4 version of the patch ...
>

The patch in that location is split in pieces, but it patches on top of
all the previous patches in the set. I could make it patch cleanly on
plain 2.4.19-pre6, but if there have been changes in the O1 scheduler
it would be better that Ingo backported them to 2.4 if he has the
time.

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.3 (Cooker) for i586
Linux werewolf 2.4.19-pre6-jam1 #1 SMP Sun Apr 7 00:50:05 CEST 2002 i686
