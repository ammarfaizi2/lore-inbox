Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291640AbSBTE7W>; Tue, 19 Feb 2002 23:59:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291642AbSBTE7D>; Tue, 19 Feb 2002 23:59:03 -0500
Received: from cs.unt.edu ([129.120.36.230]:62981 "HELO cs.unt.edu")
	by vger.kernel.org with SMTP id <S291640AbSBTE65>;
	Tue, 19 Feb 2002 23:58:57 -0500
Date: Tue, 19 Feb 2002 22:58:53 -0600 (CST)
From: Sandeep Gopal Nijsure <nijsure@cs.unt.edu>
To: linux-kernel@vger.kernel.org
Subject: About net part of the kernel
Message-ID: <Pine.LNX.3.96.1020219225420.6940B-100000@csp05.csci.unt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I want to make, say, a machine 10.0.0.5 accept an IP packet with the
destination address of 10.0.0.2. I hope I can do this by changing a bit of
kernel networking code, where it's decided whether to accept an IP packet
as a local packet.. I could not locate the code.. could anybody tell me
where exactly the decision process take place?

Thanks a lot..
Sandeep 


