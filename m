Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286273AbRLTPIK>; Thu, 20 Dec 2001 10:08:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286274AbRLTPIB>; Thu, 20 Dec 2001 10:08:01 -0500
Received: from t2.redhat.com ([199.183.24.243]:44782 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S286273AbRLTPHq>; Thu, 20 Dec 2001 10:07:46 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.LNX.4.33.0112201001510.23808-100000@bacon.van.m-l.org> 
In-Reply-To: <Pine.LNX.4.33.0112201001510.23808-100000@bacon.van.m-l.org> 
To: George Greer <greerga@m-l.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: File copy system call proposal 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 20 Dec 2001 15:07:43 +0000
Message-ID: <11478.1008860863@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


greerga@m-l.org said:
>  What does a copy system call have to do with the file server program
> being smart enough to do a copy locally?  You can't do it with FTP (or
> at least the ftpd I have) but it's certainly not because
> read()+write() are insufficient. 

Think smbfs.

--
dwmw2


