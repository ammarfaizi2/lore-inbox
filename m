Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262632AbULPH7V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262632AbULPH7V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 02:59:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262634AbULPH7V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 02:59:21 -0500
Received: from rproxy.gmail.com ([64.233.170.200]:13193 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262632AbULPH7T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 02:59:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=ATZzvKugZ3EoaioI9mS/3qWYjfsZio0LmnnMRnODPKqwjgi47EIhE7CDABdbxgFwFfS/m1qWkBRZGt/xZJoz/MTqNT3myjtfTujZCLaxiNYOCrAHPyCq4fGte5TJ4LmBV3TuTlzGGkKyeZljx9DyxUvD0Oukl42UMx7EYRByj+w=
Message-ID: <73e6204504121523591cb0874d@mail.gmail.com>
Date: Thu, 16 Dec 2004 15:59:18 +0800
From: zhan rongkai <zhanrk@gmail.com>
Reply-To: zhan rongkai <zhanrk@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: About task->used_math and TIF_USEDFPU
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi all,

I am a little confused about the task_struct member 'used_math', and
thread_info flag TIF_USEDFPU.

What are their meaning, and what is the difference between them?

thanks.
