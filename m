Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133018AbRDKWzj>; Wed, 11 Apr 2001 18:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133016AbRDKWzZ>; Wed, 11 Apr 2001 18:55:25 -0400
Received: from jalon.able.es ([212.97.163.2]:39310 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S133010AbRDKWxx>;
	Wed, 11 Apr 2001 18:53:53 -0400
Date: Thu, 12 Apr 2001 00:53:45 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: info <5740@mail.ru>
Cc: linux-kernel@vger.kernel.org, Petr Vandrovec <VANDROVE@vc.cvut.cz>
Subject: Re: 2.4.3 compile error No 4
Message-ID: <20010412005345.A2802@werewolf.able.es>
In-Reply-To: <01041111564300.02619@sh.lc>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <01041111564300.02619@sh.lc>; from 5740@mail.ru on Wed, Apr 11, 2001 at 12:34:55 +0200
X-Mailer: Balsa 1.1.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 04.11 info wrote:
> OS: Mandrake 6.0RE
> AMD K6-200 144 M
> gcc 2.95.2-ipl3mdk
> 

Have you checked in linux/Documentation/Changes if you have all the tools
and required versions for 2.4.3 ? Still running a 6.0 ?
'cause your error messages look like stupid things misunderstood by cpp.
Check if you updated gcc-cpp to the same version as gcc. And binutils
(mainly for the linker).

-- 
J.A. Magallon                                          #  Let the source
mailto:jamagallon@able.es                              #  be with you, Luke... 

Linux werewolf 2.4.3-ac3 #1 SMP Thu Apr 5 00:28:45 CEST 2001 i686

