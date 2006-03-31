Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932094AbWCaOdd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094AbWCaOdd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 09:33:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932098AbWCaOdd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 09:33:33 -0500
Received: from zproxy.gmail.com ([64.233.162.204]:43357 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932094AbWCaOdd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 09:33:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=kbajL5LQSq0xJuyxQ7xyRakCUy1rktXQPUkRREm50VuLOyKbVOzfEggeZOBWQymHNZ+SQU7wOr6bD0jJZSwKqWZnG1axRl+hrue553hBgVln/j+etCtAB0amOi6haSwWznabY8vJV7u7W52w9eY+hS2rHJ4Uljw4oAB9pb0hYHw=
Message-ID: <3fd7d9680603310633j230dceecoee49efe4e7de1c7a@mail.gmail.com>
Date: Fri, 31 Mar 2006 16:33:32 +0200
From: beware <wimille@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Access to a text file with a proc file
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

i've to create a simple proc file which have to access to a text file
(open, read,write and close). I wonder if it is possible?

Thanks for your answer.
