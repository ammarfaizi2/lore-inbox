Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030350AbVKHVEU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030350AbVKHVEU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 16:04:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030348AbVKHVEU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 16:04:20 -0500
Received: from xproxy.gmail.com ([66.249.82.197]:55740 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030349AbVKHVEI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 16:04:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=MlqnkZY5rSsrbSw6ExuZFswW1SeYneAj/e6GV1njJNpjFzxfmh8vtxk2kxuAsWWZCkvbDnBJ3/zH7Tc0yhPUvHEQORLC0vkGTJeGE8VdjDEuGRZpjTW90tRDjQsChqF8mGPB+CKO7pDz5qHmTfb/OfXwfgvA19rinAr8Um8fe8E=
Message-ID: <fb7befa20511081304sec70208l5d1a464e5af78f58@mail.gmail.com>
Date: Tue, 8 Nov 2005 16:04:07 -0500
From: Adayadil Thomas <adayadil.thomas@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Creating new System.map with modules symbol info
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings.

The System map that was created when compiling kernel does'nt have the symbols
of modules that are loaded later. How can I create a new System.map
with the symbols of
modules also.

Any information is much appreciated.

Thanks
