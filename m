Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313047AbSDJNGN>; Wed, 10 Apr 2002 09:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313057AbSDJNGM>; Wed, 10 Apr 2002 09:06:12 -0400
Received: from ns1.advfn.com ([212.161.99.144]:13070 "EHLO mail.advfn.com")
	by vger.kernel.org with ESMTP id <S313047AbSDJNGL>;
	Wed, 10 Apr 2002 09:06:11 -0400
Message-Id: <200204101306.g3AD67s01683@mail.advfn.com>
Content-Type: text/plain; charset=US-ASCII
From: Tim Kay <timk@advfn.com>
Reply-To: timk@advfn.com
Organization: Advfn.com
To: linux-kernel@vger.kernel.org
Subject: R/W compressed fs support??
Date: Wed, 10 Apr 2002 14:08:21 +0100
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
	Does anyone know of a Linux equivalent to DoubleSpace or whatever that 
allows you read and _write_ to a compressed partiton or filesystem (in a way 
that is transparent to the progs using the fs). I know there was e2compr but 
that doesn't seem to have been touched in nearly 2 years, and is 2.2 
specific, Infotec and the CBD patch seem to have died and zlibc seems to be a 
read only solution. I'd have thought this would have been a biggie for 
embedded device people but there doesn't seem to be anything out there. 

	Any pointers greatfully received....

T.I.A.

Tim

----------------
Tim Kay
systems administrator
Advfn.com Plc

