Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136662AbREHDgf>; Mon, 7 May 2001 23:36:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136663AbREHDg1>; Mon, 7 May 2001 23:36:27 -0400
Received: from www0r.netaddress.usa.net ([204.68.24.47]:39845 "HELO
	www0r.netaddress.usa.net") by vger.kernel.org with SMTP
	id <S136662AbREHDgO> convert rfc822-to-8bit; Mon, 7 May 2001 23:36:14 -0400
Message-ID: <20010508033612.8525.qmail@www0r.netaddress.usa.net>
Date: 7 May 2001 22:36:12 CDT
From: shreenivasa H V <shreenihv@usa.net>
To: linux-kernel@vger.kernel.org
Subject: TCP congestion window restart size
X-MSMail-Priority: High
X-Priority: 1
X-Mailer: USANET web-mailer (34FM.0700.17C.01)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

If I have to make modifications to TCP congestion handling, like congestion
window size where do I start? For examples if I need to modify the reset value
for CWND (when a tx timeout accurs). It seems like the function tcp_enter_loss
does something but I am not sure. So I was wondering if anyone could give me
all the details.

shreeni.

____________________________________________________________________
Get free email and a permanent address at http://www.netaddress.com/?N=1
