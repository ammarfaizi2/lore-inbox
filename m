Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290302AbSBSV2h>; Tue, 19 Feb 2002 16:28:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290297AbSBSV20>; Tue, 19 Feb 2002 16:28:26 -0500
Received: from caip.rutgers.edu ([128.6.236.10]:17370 "EHLO caip.rutgers.edu")
	by vger.kernel.org with ESMTP id <S290293AbSBSV2M>;
	Tue, 19 Feb 2002 16:28:12 -0500
Date: Tue, 19 Feb 2002 16:28:09 -0500 (EST)
From: Mihail Ionescu <mihaii@caip.rutgers.edu>
To: <linux-kernel@vger.kernel.org>
Subject: mmap for more than 2GB
Message-ID: <Pine.GSO.4.33.0202191623310.6384-100000@caip.rutgers.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am currently working on the porting of some programs from Solaris to
Linux. The main problem I have is that the original programs heavily use
mmap in order to access very big files (more than 4GB) (since it is a
64 bits operating system), but on Linux mmap will fail. Is there any clean
way to solve this problem? Please CC me the response at this e-mail
address: mihaii@caip.rutgers.edu.

Thank you very much,

Mihail Ionescu


