Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311779AbSCNUwT>; Thu, 14 Mar 2002 15:52:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311783AbSCNUwJ>; Thu, 14 Mar 2002 15:52:09 -0500
Received: from 216-21-153-9.ip.van.radiant.net ([216.21.153.9]:59917 "HELO
	innerfire.net") by vger.kernel.org with SMTP id <S311780AbSCNUv6>;
	Thu, 14 Mar 2002 15:51:58 -0500
Date: Thu, 14 Mar 2002 13:23:19 +0000 (/etc/localtime)
From: <gmack@innerfire.net>
To: linux-kernel@vger.kernel.org
Subject: interface inconsistancy between ipv4 and ipv6
Message-ID: <Pine.LNX.4.21.0203141320040.1616-100000@innerfire.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've noticed that while ipv4 responds to a given ip no matter what
interface the request is on but ipv6 only responds on the interface the
address is attatched to.

Is there a reason for the diffrence?  It seems rather odd to me that they
aren't the same.

	Gerhard

--
Gerhard Mack

gmack@innerfire.net

<>< As a computer I find your faith in technology amusing.

