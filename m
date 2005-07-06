Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262106AbVGFIFU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262106AbVGFIFU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 04:05:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262144AbVGFIFU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 04:05:20 -0400
Received: from zproxy.gmail.com ([64.233.162.194]:35444 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262106AbVGFGc0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 02:32:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=fYDu0VOmcg5CLR8PkLDae9e65DVjxalHKOxjXAdln45gDjVbqDyiyaz7Ax5Gw1Vs9U+zhhFO/oKa2LJBXQbWXLs3HgGP7rW3KVFpj8nneQ0YbYTdjQkS8bZWqy8TPWWOqLG1OmGyOC3/6feZWJNlVctSRFqLsOVoJnLMOT06bUA=
Message-ID: <b386e6140507052332616b131f@mail.gmail.com>
Date: Wed, 6 Jul 2005 12:02:26 +0530
From: Bhagyashri Bijwe <bhagyashri.bijwe@gmail.com>
Reply-To: Bhagyashri Bijwe <bhagyashri.bijwe@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: bios interaction with linux kernel after uncompression.
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
     During bootstrapping,  bios provides services like video ,hard
drive services, memory sizing, PCI table to linux kernel.
     After uncompression of kernel , Does linux kernel have any
interaction with bios?
    I know that most of work is done by linux device driver. 
    What is dependency of running linux on bios ?
  Thanks in advance,

-- 
***********************************************
   Ms Bhagyashri Bijwe
     Project Eng.
     Networking and Internet Software Group,
     Centre for Research and Development,
     Pune,India
     Ph.25694000 Ext-484/462
     B.E.( Computer Sci. and Engg. )
