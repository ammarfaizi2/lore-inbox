Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262398AbUKLTp1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262398AbUKLTp1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 14:45:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262370AbUKLTp0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 14:45:26 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:63732 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261903AbUKLTpL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 14:45:11 -0500
Message-ID: <419512C0.4070108@nortelnetworks.com>
Date: Fri, 12 Nov 2004 13:45:04 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Diego <foxdemon@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Some ideas about % of CPU for a process
References: <d5a95e6d0411121047690a0b51@mail.gmail.com>
In-Reply-To: <d5a95e6d0411121047690a0b51@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Diego wrote:
> Hi,
>  I´m trying to define a % of cpu for a process, but i don´t have idea
> about how i can do it. For example, i said that my process need 40% of
> CPU during its lifetime, how can i do it in kernel 2.6?

Take a look at CKRM.

Chris
