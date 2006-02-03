Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932510AbWBCEP0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932510AbWBCEP0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 23:15:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932521AbWBCEP0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 23:15:26 -0500
Received: from uproxy.gmail.com ([66.249.92.196]:23637 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932510AbWBCEPZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 23:15:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=WsRe4tHJFbANzTaWoO1XxbaEkGXxXtWtnYV2OAgZ+J7bqUK2XgQ9PLQQgYMf+fCbdfwc2bpGbcXj51oLT6kg4t5ZI1jdvOEnKvsIWFAx5jvI+Ua6G9pvqcYfiL+NDIYKQ2gwfgiXtMKRHrc17GclOJUMYu4HwETFBW5TvddFwi4=
Message-ID: <993d182d0602022015j70bff250x2524c6c5917be2a7@mail.gmail.com>
Date: Fri, 3 Feb 2006 09:45:23 +0530
From: Conio sandiago <coniodiago@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: time function behaving strane
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
i am using time function in my application.
When i call the try function in a loop of say 1 lac iterations then i
m facing strange behaviour.

What i am doing is that i am making a call twice to time function
inside every iteration and i compare the time of both the calls.
But sometimes the time obtained from recent call is 1 second less than
the previous call.

Has anybody observed such kind of problem??
