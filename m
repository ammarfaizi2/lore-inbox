Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261985AbTEUK1m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 06:27:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262029AbTEUK1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 06:27:42 -0400
Received: from octopus.com.au ([61.8.3.8]:1547 "EHLO octopus.com.au")
	by vger.kernel.org with ESMTP id S261985AbTEUK1j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 06:27:39 -0400
Message-ID: <3ECB57A4.1010804@octopus.com.au>
Date: Wed, 21 May 2003 20:40:36 +1000
From: Duraid Madina <duraid@octopus.com.au>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4b) Gecko/20030512
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: arjanv@redhat.com
Cc: davidm@hpl.hp.com, linux-kernel@vger.kernel.org, linux-ia64@linuxia64.org
Subject: Re: [Linux-ia64] Re: web page on O(1) scheduler
References: <16075.8557.309002.866895@napali.hpl.hp.com> <1053507692.1301.1.camel@laptop.fenrus.com>
In-Reply-To: <1053507692.1301.1.camel@laptop.fenrus.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Arjan,


       ///////
       //    O
      //      >                                    This is a graduate
       / \__ ~                                     student, laboratory
         ||                            /////       assistant, automotive
       (\ \)   (~)                    //  o   <--- engineer or other
       ( \ \  / /                    //    >       unfortunate soul
       (  \ \/ /         ____________/ \__O        attempting to get
       (   \__/         /  ___ ______\//           performance out of a
       /   | /@        (  /  / ______)/            machine running Linux
      (    |//          \ \ / /   (_)              by writing a simple
       \   ()            \ \O/                     and correct
        \  |              ) )                      multithreaded program.
         ) )             / /
        (  |_           / /_
        (____>         (____>

           ^
           |
           |
           |
           |

      This is you.



	(with apologies to the haxor brothers,)

	Duraid.


Arjan van de Ven wrote:
 > oh you mean the OpenMP broken behavior of calling sched_yield() in a
 > tight loop to implement spinlocks ?


