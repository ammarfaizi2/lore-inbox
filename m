Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751742AbWEIJLT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751742AbWEIJLT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 05:11:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751743AbWEIJLT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 05:11:19 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:64079 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751726AbWEIJLT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 05:11:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=TGnfGtqWv+y1MkAFc6tLqDq85aWDGf0tVQ7v3R/ePmz6jlP3bYT/VBTDjJ9F/9UdX+Ttgqci7fJWK5yDekPiKgZcZIo6G1J/HESRDc6sE5xzvM5jNfjF3RreLI3RxPFkyEPtfbVbSx62F0sQmr2B+f309QauOsaoQkkCenoCtJ8=
Message-ID: <bae323a50605090211t6af09c75u7cab1aac71e0e412@mail.gmail.com>
Date: Tue, 9 May 2006 11:11:17 +0200
From: "Carlos Ojea Castro" <nuudoo.fb@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: LPC bus in a geode sc1200
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

I wrote a driver to use LPC bus in a geode sc1200. For now I am able
to transmit an read or write "I/O cycle" to the LPC.
What I want to do now is to read or write to the LPC using a "Memory cycle".

Anyone knows how can I archieve this?
is there another list more suitable for my question?

Thanks,
Carlos
