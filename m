Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285041AbRLKNlO>; Tue, 11 Dec 2001 08:41:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285030AbRLKNlE>; Tue, 11 Dec 2001 08:41:04 -0500
Received: from [202.54.64.2] ([202.54.64.2]:18180 "EHLO ganesh.ctd.hctech.com")
	by vger.kernel.org with ESMTP id <S285035AbRLKNky>;
	Tue, 11 Dec 2001 08:40:54 -0500
Message-ID: <EF836A380096D511AD9000B0D021B5273EFC6F@narmada.ctd.hcltech.com>
From: "Eshwar D - CTD, Chennai." <deshwar@ctd.hcltech.com>
To: linux-kernel@vger.kernel.org
Subject: Problem SMBFS
Date: Tue, 11 Dec 2001 19:08:09 +0530
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hai,
	
	When i read a file xyz (file is in smbfs mounted directory) from one
client and i am didn't closed, from second client i written some data using
write system call and closed xyz file,  i am not see the data from client
one. Then i closed file in client one and tried to read the data, same thing
is continuing. Can any one suggest me is this is the property of smbfs. I am
not a member in mailing list please send me u r request to my mail id

Thanks
Eshwar
