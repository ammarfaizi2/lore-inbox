Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261868AbTFBE6n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 00:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261872AbTFBE6n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 00:58:43 -0400
Received: from crufty.research.bell-labs.com ([204.178.16.49]:32010 "EHLO
	crufty.research.bell-labs.com") by vger.kernel.org with ESMTP
	id S261868AbTFBE6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 00:58:43 -0400
Message-Id: <200306020512.h525C1c6083697@grubby.research.bell-labs.com>
Date: Mon, 2 Jun 2003 01:10:14 -0400
To: linux-kernel@vger.kernel.org
From: "netlib server" <netlibd@research.bell-labs.com>
Subject: netlib syntax error
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, the netlib program couldn't understand your request.  
Here are some example requests, in case syntax is the problem:
                   
          send index
          send index for eispack
          send rg from eispack
          who is Gene Golub
          find fft

Due to the stupid, one-pass nature of the parsing program, if you
put the request in the header Subject: line and some mailer puts
that line before any address line, netlib won't know who you are.
Sorry, that will be fixed someday;  in the meantime, put the
request in the message body proper.

Your mail, as received here, was...



