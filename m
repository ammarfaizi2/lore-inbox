Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262791AbVG2TzU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262791AbVG2TzU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 15:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262798AbVG2TzQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 15:55:16 -0400
Received: from wproxy.gmail.com ([64.233.184.193]:1663 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262791AbVG2Txa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 15:53:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=t+nSpM0kqYqkxV6QPGG/sUfNnkRNmWFZ4sE5SkIljkz7lwf3OAfYgf3pYoCWIH5nQaaoxkotvTl42nTswcV2hUkU7nLhwl/AwKPpYJL067SIYc9UgvbEpZP7jNYCtiF58mjGQloObYOPJLM/bhzfEFGAJLVxAEsY1x+vVtowoiw=
Message-ID: <4ae3c14050729125341eaf846@mail.gmail.com>
Date: Fri, 29 Jul 2005 15:53:26 -0400
From: Xin Zhao <uszhaoxin@gmail.com>
Reply-To: Xin Zhao <uszhaoxin@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Where can I find some source code to dump user_stack?
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I know in kernel level we have dump_stack, but is there anyway that we
can dump user stack in the kernel environment?  I might want to dump
the calling trace in a system call function.

Thanks in advance!

-x
