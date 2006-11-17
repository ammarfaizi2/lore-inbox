Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755814AbWKQTMc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755814AbWKQTMc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 14:12:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755816AbWKQTMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 14:12:32 -0500
Received: from moutng.kundenserver.de ([212.227.126.188]:25030 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1755806AbWKQTMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 14:12:30 -0500
Date: Fri, 17 Nov 2006 20:12:21 +0100
From: Chris Friedhoff <chris@friedhoff.org>
To: "Bill O'Donnell" <billodo@sgi.com>
Cc: KaiGai Kohei <kaigai@ak.jp.nec.com>, "Serge E. Hallyn" <serue@us.ibm.com>,
       linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
       Stephen Smalley <sds@tycho.nsa.gov>, James Morris <jmorris@namei.org>,
       Chris Wright <chrisw@sous-sol.org>, Andrew Morton <akpm@osdl.org>,
       KaiGai Kohei <kaigai@kaigai.gr.jp>,
       Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH 1/1] security: introduce fs caps
Message-Id: <20061117201221.667b84d7.chris@friedhoff.org>
In-Reply-To: <20061116144743.GA21497@sgi.com>
References: <20061108222453.GA6408@sergelap.austin.ibm.com>
	<20061109061021.GA32696@sergelap.austin.ibm.com>
	<20061109103349.e58e8f51.chris@friedhoff.org>
	<20061113215706.GA9658@sgi.com>
	<20061114052531.GA20915@sergelap.austin.ibm.com>
	<20061114135546.GA9953@sgi.com>
	<20061114152307.GA7534@sergelap.austin.ibm.com>
	<455B0357.2050400@ak.jp.nec.com>
	<20061115170633.GA21345@sgi.com>
	<20061115224923.539fe60a.chris@friedhoff.org>
	<20061116144743.GA21497@sgi.com>
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.8.20; i486-slackware-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Fri__17_Nov_2006_20_12_21_+0100_k9XVuDbfunwOXmaC"
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:9d7f00276fac4b25ba506f26988c1e36
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart=_Fri__17_Nov_2006_20_12_21_+0100_k9XVuDbfunwOXmaC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

compiling fscaps-1.0-kg.src.rpm just gives the same result
/bin/ping: Invalid argument (errno=22)
trace output attached

Chris

--------------------
Chris Friedhoff
chris@friedhoff.org

--Multipart=_Fri__17_Nov_2006_20_12_21_+0100_k9XVuDbfunwOXmaC
Content-Type: application/octet-stream;
 name="strace-ping-sles10-b.gz"
Content-Disposition: attachment;
 filename="strace-ping-sles10-b.gz"
Content-Transfer-Encoding: base64

H4sICHZ6XUUAA3N0cmFjZS1waW5nLXNsZXMxMC1iAK1WbXPaOBD+3l+h4ZPpOFh+wWBmuBsKTo85
MKkhaTOXjka2BfHE2B7JUHJJ//utDK0h5OXaBOOXkXZXq2cfP2vTdByE2IaFa6bUtJXgmuChltPw
hi6Y0KaTc7/vTjXBinlIc1FT0T8vmtUajYaKamBPUlYQTr91WQ6eNS2IUy2P00XtK8TR3qOmjdaU
C/Re+1pHXYTfmWU+Ab9RcB098wPbTRtbFOMfPsslzQ3FOx+NVGRhx1bRmT+ZEd/tDe7Lp8/+cOaq
aNw7I2f+8KI3c+/lc8+beJfjyflURSe6inCZxyZozU1WBadhyIQAgFgRaknUEFkj5yzJaATb8snk
b+l1oiPXm7jeDClehsQqvEbzOGEo4yiKOQuLjN/WdwGznKUH4UIaXjMINiH+YOKNLmVAc2c8FwUt
bEsxVXQnCrLMItadkuGp7368x7ZlqQhGRfwv6zZtxwQrwP/7Pp772OxMfoJzgIiKzAMIcAVBmGSC
KeYzVanW2+0uiQN5Ag/kDvUndscZjeTWald6q+WOTq/08sBHh7k7q7m5vGK85VtTN2RYuP0f2FrN
ZgWbjq2m/TxsusTiiFPuF7d/TKmB613u2HYApxHu0ZVG6xgArSZ+rjHuDS7I1P10DlQa9kb3eKMf
Z7X1m5cOv0L30+EXd/BYlhujynP+JmWXRbcPiv4WVQeMLq/015fcwpZhGS8UXW/ZTrv9urIz/ETZ
txN7q/xC4ZtbT9tsW6+vvK63q9o3H0rqdtgpF3Rs4xiNF9d7UmLLqL9BtLfWeoaDKhHoYaS4lvwk
FK7KHUsLfkvS1TJgvAMif/IHghUDKhihUcQ7uwh2AAAl8TIuOqAn7WZLso0tiGkEckhFYZYWEEt0
wK4ML9suydLktvPDk8QpyWVHlfbSOc0KAp1GgJ80WglGg4R19EPK5jwroL8ccKOtO8YeLgf2qxQA
VCqJ33WF+iNQ/04rLn1gzJaoPuq79bH3UIcmsWByB7rjtLFpQk7wv9ve8PdSO2SDHXoXvRFShuma
JnGEKF+slgBO/YEA6A8EoP+XD63SwKUA8Iitu0t6w+CuwPuj149lIM7CIpFhpt6gPxuR2dgns+HY
/dCburKjz/of3Rnw6O4DvIIYg/ZlokCxiBcoDmmapYiF19mz6vI2XylRheE3HhdM5lx9aHXQQ6SQ
wjjfyqfplH3Y2bmzDRBwwbNV/lTFu+jPd/8BeENG+jIKAAA=

--Multipart=_Fri__17_Nov_2006_20_12_21_+0100_k9XVuDbfunwOXmaC--
