Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131626AbREIUZf>; Wed, 9 May 2001 16:25:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131563AbREIUZ0>; Wed, 9 May 2001 16:25:26 -0400
Received: from parsys.eecs.uic.edu ([131.193.39.100]:8716 "EHLO
	parsys.eecs.uic.edu") by vger.kernel.org with ESMTP
	id <S131498AbREIUZP>; Wed, 9 May 2001 16:25:15 -0400
Date: Wed, 9 May 2001 15:29:11 -0500 (CDT)
From: Krishnan Ananthanarayanan <kanantha@parsys.eecs.uic.edu>
X-X-Sender: <kanantha@atlanta.eecs.uic.edu>
To: <linux-kernel@vger.kernel.org>
Subject: Question
Message-ID: <Pine.LNX.4.32.0105091527060.20529-100000@atlanta.eecs.uic.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  I was wondering if there is any mechanism to notify a module of an event
such as arrival of data on a socket. I am trying to find out if a function
in a module can be invoked if such an event occurs. This solves the
problem of polling the socket for data.

Thanks a ton in advance.
Krishnan.

