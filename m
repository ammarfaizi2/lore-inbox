Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964971AbWBGEDa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964971AbWBGEDa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 23:03:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964970AbWBGEDa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 23:03:30 -0500
Received: from pproxy.gmail.com ([64.233.166.180]:51884 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964971AbWBGED3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 23:03:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=oZzmfRN7EsjeX6SdMGLTTOs3wwrOM2q0f8eJqvFDdAI2sRXtq06o68mYmV3EwcTHT7QgfqxKnHVxLxLLfSlZv+gC34sunXWL5bqK4wSu1WVAJ3KAOg0hOC4/BcUEH8VnP7f/vlYp2QFLkOI0Ap6htytCTWa8Es/00Q+FmSyOD3k=
Message-ID: <aed62bae0602062002m6e0f05aes1a50fbc72f2d0f8a@mail.gmail.com>
Date: Tue, 7 Feb 2006 09:32:55 +0530
From: sarat <saratkumar.koduri@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: sk_buff
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello .. i have a packet capture program which will capture a packet
using netfilter hooks and it will queues for user interface.. can some
body tell me.. how to retrive data using libipq.. i think data was
stored in sk_buff ..

--
ur's sarat
