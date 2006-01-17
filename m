Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932477AbWAQNa2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932477AbWAQNa2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 08:30:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932479AbWAQNa2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 08:30:28 -0500
Received: from wproxy.gmail.com ([64.233.184.195]:3994 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932477AbWAQNa1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 08:30:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=WooGL49Lon+z34K8iMw8ndr+Z5N+faX6b5oFgv3VWYAxNXOIXrCSp82p0WapFH/2HPYMNlwn8jFSFXQnwlllQkTdbapSEtlOIvWo3xgfuZjJBsQrojIk/CFk/Sxe4kDp4ZXmcAAqkPEUi/IUN6vcvp8FYR2WQyLChHf9ysSou9w=
Message-ID: <4c50d3ee0601170530p2cbe98b8k@mail.gmail.com>
Date: Tue, 17 Jan 2006 14:30:26 +0100
From: =?ISO-8859-1?Q?Th=E9ophile_Helleboid_-_Chtitux?= 
	<chtitux@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: No kexec in menuconfig in 2.6.16-rc1
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I don't see the kexec option on linux-2.6.16-rc1
I have in my menuconfig :
     Timer frequency (250 HZ)  --->
and it's all
This option has been removed ?
I can see kexec in the search with /

--
Chtitux -
Théophile Helleboid
