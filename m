Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946203AbWJ0KQN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946203AbWJ0KQN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 06:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946305AbWJ0KQN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 06:16:13 -0400
Received: from web27406.mail.ukl.yahoo.com ([217.146.177.182]:31676 "HELO
	web27406.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1946203AbWJ0KQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 06:16:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.uk;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=f4GVshuF+3oEwEYPIOM9Ocb7D8bIxfSGzvXoG2rG0StOVgXHV1XOVhEYoPcUKdMku4ZhO8157cQRWOLrE3VfidWJPN7ZE7HWz5KKJfmG0g2Nl+orbGZGv7TpcMJk+Xbo3NlmrGaJmTt76wAK3STQ9qnr93qVBEymdhh2iKbp6HE=  ;
Message-ID: <20061027101611.67643.qmail@web27406.mail.ukl.yahoo.com>
Date: Fri, 27 Oct 2006 11:16:11 +0100 (BST)
From: ranjith kumar <ranjit_kumar_b4u@yahoo.co.uk>
Subject: How to run an a.out file in a kernel module
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

          How to run an a.out file in a kernel module
             I tried to include
                                    system("./a.out");
     in the C file. But I got compilation errors.

Thanks in advance.

Send instant messages to your online friends http://uk.messenger.yahoo.com 
