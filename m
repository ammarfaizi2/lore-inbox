Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932176AbVIECAq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932176AbVIECAq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 22:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932178AbVIECAq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 22:00:46 -0400
Received: from web50215.mail.yahoo.com ([206.190.39.201]:50013 "HELO
	web50215.mail.yahoo.com") by vger.kernel.org with SMTP
	id S932176AbVIECAp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 22:00:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=Fob9ZeBCELK8FC0tPF+ImJdmVMwOExuoUSl+J2Tj4ywYYhTH8O2bQbknklIOa/kRrMTDWUaD8RAewgu6XoQpLxu3iHENyTvtn42yEMHcqi89ykytOESwbFDEEEKtf3Cg/x/KiQ57+vyoI2XAOFXNejo8NDK4BJcnepXipVi0a4c=  ;
Message-ID: <20050905020027.15257.qmail@web50215.mail.yahoo.com>
Date: Sun, 4 Sep 2005 19:00:27 -0700 (PDT)
From: Alex Davis <alex14641@yahoo.com>
Subject: re: RFC: i386: kill !4KSTACKS
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
>- NDISwrapper / driverloader.
>  (Shock, horror - no-one cares).

Shock, horror. Someone DOES care: everyone who uses ndiswrapper or
driverloader, whether they know it or not. Are you proposing that
we punish the end-users because of the obstinence of the hardware
manufacturers? If/when native drivers are written, maybe we can 
revisit this.



I code, therefore I am


	
		
______________________________________________________
Click here to donate to the Hurricane Katrina relief effort.
http://store.yahoo.com/redcross-donate3/
