Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281880AbRLDB6Q>; Mon, 3 Dec 2001 20:58:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275552AbRLDB4r>; Mon, 3 Dec 2001 20:56:47 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:57475 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S279105AbRLDB4H>; Mon, 3 Dec 2001 20:56:07 -0500
Date: Mon, 03 Dec 2001 17:55:57 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux/Pro [was Re: Coding style - a non-issue]
Message-ID: <2379810054.1007402157@mbligh.des.sequent.com>
In-Reply-To: <m1pu5xwaez.fsf@frodo.biederman.org>
X-Mailer: Mulberry/2.0.8 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> As far as I can tell the only real difference between a numa box, and
> a normal cluster of machines running connected with fast ethernet is
> that a numa interconnect is a blazingly fast interconnect.  

Plus some fairly hairy cache coherency hardware.

> So if you
> can come up with a single system image solution over fast ethernet a
> ccNuma machine just magically works.

it's not cc if you just use fast ethernet.

Martin.

