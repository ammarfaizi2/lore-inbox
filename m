Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280588AbRKBHay>; Fri, 2 Nov 2001 02:30:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280590AbRKBHae>; Fri, 2 Nov 2001 02:30:34 -0500
Received: from saga21.Stanford.EDU ([171.64.15.151]:55035 "EHLO
	saga21.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S280589AbRKBHa1>; Fri, 2 Nov 2001 02:30:27 -0500
Date: Thu, 1 Nov 2001 23:30:21 -0800 (PST)
From: Ken Ashcraft <kash@stanford.edu>
To: <linux-kernel@vger.kernel.org>
cc: <engler@stanford.edu>
Subject: null pointer questions
Message-ID: <Pine.GSO.4.33.0111012322470.5198-100000@saga21.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Two questions:
1. If I pass size 0 to kmalloc, what does it return?

2. What happens if I pass a null pointer as the destination parameter
to copy_from_user?  Does copy_from_user handle it safely or will the
kernel seg fault?

Thanks for your answers,
Ken Ashcraft

