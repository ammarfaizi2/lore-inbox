Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289213AbSAVJu5>; Tue, 22 Jan 2002 04:50:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289212AbSAVJuq>; Tue, 22 Jan 2002 04:50:46 -0500
Received: from mx2.elte.hu ([157.181.151.9]:9942 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S287493AbSAVJu3> convert rfc822-to-8bit;
	Tue, 22 Jan 2002 04:50:29 -0500
Date: Tue, 22 Jan 2002 12:47:52 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Cc: Partha Narayanan <partha@us.ibm.com>, Andrea Arcangeli <andrea@suse.de>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Performance Results for Ingo's O(1)-scheduler
In-Reply-To: <20020122053444.A30EE6DA96@mail.elte.hu>
Message-ID: <Pine.LNX.4.33.0201221247070.2826-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 22 Jan 2002, Dieter [iso-8859-15] Nützel wrote:

> > KERNEL              UP          4-way       8-way
> > =========  ======      ======      ======
> >
> > 2.4.17              11005       15894       11595
> [-]
>
> Would you be so kind to redo it with 2.4.18pre2aa2 (Andrea's 10_vm-22) stuff?

prediction: the results wont change a bit.

VolanoMark has no sensitivity on VM issues at all.

	Ingo

