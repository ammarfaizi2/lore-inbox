Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318250AbSGWXWU>; Tue, 23 Jul 2002 19:22:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318253AbSGWXWU>; Tue, 23 Jul 2002 19:22:20 -0400
Received: from relay1.pair.com ([209.68.1.20]:26128 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id <S318250AbSGWXWT>;
	Tue, 23 Jul 2002 19:22:19 -0400
X-pair-Authenticated: 24.126.73.164
Message-ID: <3D3DE6B2.FD4BD529@kegel.com>
Date: Tue, 23 Jul 2002 16:28:50 -0700
From: dank@kegel.com
Reply-To: dank@kegel.com
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: re: is flock broken in 2.4 or 2.5 kernels or what does this mean?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To save others a bit of searching:
the original thread was 'broken flock()' on 28 June 2002.

Steven's post and regression test:
http://marc.theaimsgroup.com/?l=linux-kernel&m=102562226210792&w=2
Matthew Wilcox's rip-it-out patch:
http://marc.theaimsgroup.com/?l=linux-fsdevel&m=102562469813922&w=2
