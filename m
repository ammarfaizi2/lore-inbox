Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266197AbUGARho@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266197AbUGARho (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 13:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266198AbUGARho
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 13:37:44 -0400
Received: from bay16-f24.bay16.hotmail.com ([65.54.186.74]:13063 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S266197AbUGARhn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 13:37:43 -0400
X-Originating-IP: [220.224.1.194]
X-Originating-Email: [kartik_me@hotmail.com]
From: "kartikey bhatt" <kartik_me@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: socket association
Date: Thu, 01 Jul 2004 23:07:42 +0530
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY16-F245chn3g2CNq00026201@hotmail.com>
X-OriginalArrivalTime: 01 Jul 2004 17:37:42.0298 (UTC) FILETIME=[1C9AAFA0:01C45F92]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sure there is one who will help

in freebsd when a socket is created,
the process  structure of the process creating socket
is passed as an argument to socreate function.
is there any mechanism in linux kernel where we can
associate the process creating socket with the socket.
or we can fetch the process structure of the owning
process given the socket or sock data structure.

--kartikey

_________________________________________________________________
Easiest Money Transfer to India. Send Money To 6000 Indian Towns. 
http://go.msnserver.com/IN/48198.asp Easiest Way To Send Money Home!

