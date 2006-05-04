Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030301AbWEDTY3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030301AbWEDTY3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 15:24:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750829AbWEDTY3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 15:24:29 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:2980 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750732AbWEDTY3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 15:24:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:mime-version:content-type:content-transfer-encoding:x-mailer:in-reply-to:thread-index:x-mimeole;
        b=qDUPv8SRzlrTorO3H5tOL3iQipShgZKnWzKf5gXKBMXKkoSRwQnUEsQ9H36N1WY1dgnWdhv1jfsWx6KZZJHhZQprjJ8FL3dJrkVtdaH01h5aweC/JRltRt+D2AeM5sfWGR2YLuHPQJnv5MKDRg66YgtAQARbIkWuvCZvN+cyI2s=
From: "Hua Zhong" <hzhong@gmail.com>
To: "'Nuri Jawad'" <lkml@jawad.org>, "'Dave Jones'" <davej@redhat.com>
Cc: "'Linux Kernel'" <linux-kernel@vger.kernel.org>
Subject: RE: Remove silly messages from input layer.
Date: Thu, 4 May 2006 12:24:26 -0700
Message-ID: <004f01c66fb0$5c4c0150$0200a8c0@nuitysystems.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <Pine.LNX.4.64.0605041644260.32501@pc>
Thread-Index: AcZvi6oB6oT/+Q0sTwmuY/IPUUEhlAAJGIDw
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If people are "confused" by valid error messages, they can 
> use certain proprietary operating systems that hide the ugly 
> truth from them. What's next, removing "access beyond end of 
> device"? I want to stay informed if my mechanical switch 
> produces glitches. There are electronic ones that don't.

Why not maintain an error counter? You can then easily identify whether your keyboard is funky by querying the counter.

For others who don't care, life goes on.

Hua

