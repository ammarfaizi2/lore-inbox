Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751292AbWJVQwS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751292AbWJVQwS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 12:52:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbWJVQwS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 12:52:18 -0400
Received: from web27408.mail.ukl.yahoo.com ([217.146.177.184]:61818 "HELO
	web27408.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1751292AbWJVQwR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 12:52:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.uk;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=bK3HY4PHXccjTk8yapJaDKUm2G7Uz8HpLBxEX95xWAi1UpKTHKdRy/KSBfKYXvu5ozoppvr2WNsyQkhjc0XWTKzNz/MC0QnlgtbGW1oAO+WN25QRVRTniYP3DJMsZ696ruR2J4Uhzv0pCsP38Jc+oN2Oyzx38B5Q5XWBqE2mybs=  ;
Message-ID: <20061022165215.17075.qmail@web27408.mail.ukl.yahoo.com>
Date: Sun, 22 Oct 2006 17:52:15 +0100 (BST)
From: ranjith kumar <ranjit_kumar_b4u@yahoo.co.uk>
Subject: CONFIG_MODVERSION
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How to set config_modversion on/off.

I am asking this question because I got the following
error when I tried to insert a modeule which I wrote.

deogiri:/users/pg05/ranjithk/Desktop/prg#   gcc -c 3.c
deogiri:/users/pg05/ranjithk/Desktop/prg#   insmod
./3.o
insmod: error inserting './3.o': -1 Invalid module
format

Can any one help me?
Thanks.

Send instant messages to your online friends http://uk.messenger.yahoo.com 
