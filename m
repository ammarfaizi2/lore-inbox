Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030334AbWCUFp5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030334AbWCUFp5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 00:45:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030338AbWCUFp5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 00:45:57 -0500
Received: from web8712.mail.in.yahoo.com ([203.84.221.133]:62086 "HELO
	web8712.mail.in.yahoo.com") by vger.kernel.org with SMTP
	id S1030334AbWCUFp4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 00:45:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.in;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=b2dzosrZ6bfeTQ07JD6eOMlkIu1qkqxW/nrB5Ld/bTxJ9KT2zBS1RcDvel1NUADKoGxy3ws5b0Y4Xxk9qw4y7UUh1gG73tgg0ItYRCGh35Ygo3badLrCOmGakOEiB7BJ+BWRV0x3swpUY2VRY+MVThQ3ZWTTHooBcW28hedFp+Q=  ;
Message-ID: <20060321054552.64884.qmail@web8712.mail.in.yahoo.com>
Date: Tue, 21 Mar 2006 05:45:52 +0000 (GMT)
From: Amit Luniya <amit_31_08@yahoo.co.in>
Subject: Help for problem related to hibernation in linux kernel 2.6.14.5 kernel 
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello sir ,
    I am a final year student of computer enggineering
from pune university.
I am working on project of hibernation in network
environment that means client image is saved onto
server
and when required get it from server.We are utilising
the 
code of hibernation that is written in swsusp.c and
disk.c files in linux kernel 2.6.14.5. 
  Problem is that existing code of hibernation does
not support ping or any network related services after
resume from suspending.So due to this problem we cant
communicate with server and can not  get image back
from server. So what we should do to overcome from
this problem?
Please help us to find out solution from this problem.
CC at := amit_31_08@yahoo.co.in
         amit_31_08_99@yahoo.co.in 


		
__________________________________________________________ 
Yahoo! India Matrimony: Find your partner now. Go to http://yahoo.shaadi.com
