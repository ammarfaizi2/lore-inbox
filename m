Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264509AbTEaTW4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 15:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264501AbTEaTW4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 15:22:56 -0400
Received: from smtp017.mail.yahoo.com ([216.136.174.114]:61198 "HELO
	smtp017.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264744AbTEaTWw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 15:22:52 -0400
Message-ID: <3ED9042C.4030504@yahoo.com>
Date: Sat, 31 May 2003 12:36:12 -0700
From: Eric Benson <eric_a_benson@yahoo.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: must-fix, version 6
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A fully-functioning ide-scsi is extremely important. The application 
cdrecord and its derivatives require a SCSI interface to work. I don't 
know of any other CD-R/RW recording application in common use on Linux. 
Many distributions add ide-scsi boot parameters when they discover an 
IDE CD-R drive. Even though the newest development versions of cdrecord 
along with the newest versions of kernel 2.5 do not require ide-scsi, 
the installed base is enormous. This will represent a significant 
barrier to widespread adoption of 2.6 if currently installed versions of 
cdrecord with currently configured boot parameters must be updated.

