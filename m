Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263850AbUARUzh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 15:55:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263851AbUARUzh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 15:55:37 -0500
Received: from mazurek.man.lodz.pl ([212.51.192.15]:7888 "EHLO
	mazurek.man.lodz.pl") by vger.kernel.org with ESMTP id S263850AbUARUzf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 15:55:35 -0500
Date: Sun, 18 Jan 2004 22:02:37 +0100
From: Szymon Tarnowski <szymon@wpk.p.lodz.pl>
X-Mailer: The Bat! (v1.61)
Reply-To: Szymon Tarnowski <szymon@wpk.p.lodz.pl>
X-Priority: 3 (Normal)
Message-ID: <4241753368.20040118220237@wpk.p.lodz.pl>
To: linux-kernel@vger.kernel.org
Subject: [patch] remove graphic linux logo on framebuffer, kernel-2-4-24
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----------11F1106739C9F5DC"
X-mazurek.man.lodz.pl-MailScanner-Information: Please contact bilbo@man.lodz.pl
X-mazurek.man.lodz.pl-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------------11F1106739C9F5DC
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello everyone
  I have made this cosmetic patch to remove linux graphics logo
presented during booting system. I have no objection to logo but when
console is ready to log in the system, I would like to remove it from
screen. Because I don`t have enought programing skils and enought free
time to solve this problem, I made this patch to remove logo at all.
It is made by changing value sent do framebuffer setup routine. Please
fell free to coment my patch, please send it to me directly because I
don`t receive subscription from linux-kernel message list. Please also
inform me if there will be big discusion at list.

-- 
Best regards,
 Szymon                             mailto:szymon@wpk.p.lodz.pl
------------11F1106739C9F5DC
Content-Type: application/x-gzip; name="nologo.tar.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="nologo.tar.gz"

H4sICITvCkAAA25vbG9nby50YXIA7ZZtb+I4EMf7dvMppr3Ttd2Q4IRAu+xdBS20QqKwarnqVqsV
CokDVoMd2Q4s++nPJrSlzw9Sb3WSfy8wOOPxzPjvIWftZuu0vfGuIA+hWhBsoIK7I/Jq/oYyQX61
tlcNfG0fVKobgN43rIJcyJADbHDG5FN2zz3/n3LExBRLEkEWymgCkgHHUzbDMOZhNlHzKaH5D0jZ
mEEo1fMMWAIJD6d4lCcJ5i40czlhvA7nPxdTRmEQcsrm4pLAn2I505hnl27mpiz+6Wbpwa/O2LAO
Zfpo3Zgkybvt8cz9D1ANXd9/z6soe6+2t2fu/3+BPnhwcnA4lHPBy4JH5VF4WV5ee8d3A9cPyi0W
5VNMZSgJo+UjRhMyzjl2JzjNbpa9eInlOM4bd/vgI1RxPM/x98H7VPdrde+Te/U/gsDWUrNs235D
VNp14CDP8fbB9+oVVA/uu240wKlWK6hUA3s5ej40GhYAdBJYsByyNKS6i+YCg5xg6B61ICZCTS9g
TuREG3E4b6oclFOxEBJPSyDChfbxFSZYRWOBZbeICEcpXmu/ln3U7x13TobHh+rLsNfv9k/6ln29
85zlaazsL/FaF3+wey9DWLZwKHp4SbtRMawC0L9e2dRV8KCXWdCMZyGNsIqEzSHFM5xCzMkMc2CZ
rrqw4FYezdZFs3fUbun8B6pg63FBpOyZqoKqpoBoEvIwkmo65uGc0DFwlktC1SM5UdmFKvIXybmI
R5RnJMZspQKX0Ec084j1MyJ+ZNV9/froFfp9wuu1dFG9ohxXHpSuX6mU9sEuhkK3kJDlQBL4Blu/
r86m/c+X9lnntN0bNLtb8BdsLbbg+2etaLq0VkhOVOuUGLYBLgiXeZjC8fLwDovDE3mWMS5hp9/r
foXj/hkM2ueDTu9kcxd21jfY3b6RxPCiczb4u9nVYtKMGEv1Dvfvw+M+1q7HKkHHWvf1rES3H5fo
nTrdNnhBpQBOGWXRhDNVqFWF7mx3enz4Fh0nI3Vb3OhFylnZvkrDqzWFgtG+41fBq9SDoB74t7Tm
v0LBaz7X9Ku7uvdw60VeaU91XjV43pWAIRkNVy32W06J/O5G0zBzxxxjqg4EfX7KapTm+FkjyUMq
ssLM/o0kMU4eVJtduFA5DQWWebajfZSALD/Rrl6MU4GvtnrYblMPhS1VMiiMyx/hVL2pwAhDzCiG
MNF9cM2F7vkZV1qmEvCPCAsBeRYr0Qn4WC58KNvMOZhFVxkOk7FK6Q9CE+Yc3MytKqF0vrN599mu
9avfVwwGg8FgMBgMBoPBYDAYDAaDwWAwGAxP8y98wPQWACgAAA==

------------11F1106739C9F5DC--

