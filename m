Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129396AbRA0CHM>; Fri, 26 Jan 2001 21:07:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129413AbRA0CHB>; Fri, 26 Jan 2001 21:07:01 -0500
Received: from blackdog.wirespeed.com ([208.170.106.25]:32272 "EHLO
	blackdog.wirespeed.com") by vger.kernel.org with ESMTP
	id <S129396AbRA0CGs>; Fri, 26 Jan 2001 21:06:48 -0500
Message-ID: <3A722DF7.60609@redhat.com>
Date: Fri, 26 Jan 2001 20:09:59 -0600
From: Joe deBlaquiere <jadb@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22 i686; en-US; m18) Gecko/20001107 Netscape6/6.0
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Is it possible to force don't fragment on a socket?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to test a communications path to a remote system and was 
wondering if I could force the DF bit on some UDP traffic. Does anybody 
know of a way to do this??

TIA,
Joe

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
